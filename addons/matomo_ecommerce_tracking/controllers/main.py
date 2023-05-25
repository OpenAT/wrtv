# -*- coding: utf-8 -*-
import cStringIO
import datetime
from itertools import islice
import json
import xml.etree.ElementTree as ET
from piwikapi.tracking import PiwikTrackerEcommerce


import logging


import openerp
from openerp.addons.web import http
from openerp.http import request, STATIC_CACHE
from openerp import SUPERUSER_ID
from lxml import etree

from jinja2 import Environment, BaseLoader

logger = logging.getLogger(__name__)


class DummyRequest:
    COOKIES = False
    META = {}
    secure = True

    def is_secure(self):
        return self.secure


class WebsiteConfirm(openerp.addons.web.controllers.main.Home):

    @http.route('/confirm/<page:page>', methods=["GET"], type='http', auth="public", website=True)
    def confirm(self, page, **opt):
        values = {
            'path': page,
        }
        # /page/website.XXX --> /page/XXX
        if page.startswith('website.'):
            return request.redirect('/page/' + page[8:], code=301)
        elif '.' not in page:
            page = 'website.%s' % page

        try:
            request.website.get_template(page)
        except ValueError, e:
            # page not found
            if request.website.is_publisher():
                page = 'website.page_404'
            else:
                return request.registry['ir.http']._handle_exception(e, 404)

        order_id = opt.get('order_id')

        if order_id:
            order_pool = request.registry.get('sale.order')
            payment_pool = request.registry.get('payment.transaction')
            order = order_pool.search_read(request.cr, SUPERUSER_ID, [('id', '=', order_id)])
            payment_id = order[0]["payment_tx_id"][0]
            payment = payment_pool.search_read(request.cr, SUPERUSER_ID, [('id', '=', payment_id)])
            payment_state = payment[0]["state"]
            amount_total = order[0]["amount_total"]

            if payment_state in ["done", "pending"]:
                logger.info("CONFIRM: order_id: %s with amount_total: %s" % (order_id, amount_total))
                WebsiteConfirm.matomo_ecommerce_track(order_id, amount_total)

        return request.render(page, values)

    @staticmethod
    def matomo_ecommerce_track(order_id, amount):
        site_id = 1
        request = DummyRequest()
        api_url = "https://stats.tierschutz-austria.at/js/container_ajZJDoyi.js"

        tracker = PiwikTrackerEcommerce(site_id, request)
        # tracker.set_token_auth()
        tracker.set_api_url(api_url)
        tracker.do_track_ecommerce_order(order_id=order_id, grand_total=amount)
        logger.info("MATOMO: do_track_ecommerce_order(order_id=%s, grand_total=%s) success!" % (order_id, amount))
