# -*- coding: utf-8 -*-

import re
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
            line_pool = request.registry.get('sale.order.line')

            order = order_pool.search_read(request.cr, SUPERUSER_ID, [('id', '=', order_id)])
            payment_id = order[0]["payment_tx_id"][0]
            payment = payment_pool.search_read(request.cr, SUPERUSER_ID, [('id', '=', payment_id)])
            payment_state = payment[0]["state"]
            amount_total = order[0]["amount_total"]

            lines = line_pool.search_read(request.cr, SUPERUSER_ID, [('id', 'in', order[0]["order_line"])])

            if payment_state in ["done", "pending"]:
                logger.info("CONFIRM: order_id: %s with amount_total: %s" % (order_id, amount_total))

                payment_confirmation_data = {
                    "order_id": order_id,
                    "amount_total": amount_total,
                    "order_items": [
                        {
                            "id": line["id"],
                            "product_id": line["product_id"][0],
                            "name": WebsiteConfirm.js_escape(line["name"]),
                            "category": lines[0]['cat_id'][1] if lines[0]['cat_id'] else "",
                            "quantity": int(line["product_uos_qty"]),
                            "price": line["price_donate"],
                        } for line in lines
                    ],
                }
                values["payment_confirmation"] = payment_confirmation_data

        return request.render(page, values)

    @staticmethod
    def js_escape(value):
        sanitized_string = re.sub(ur'[^a-zA-Z0-9äöüÄÖÜß\(\)\[\]\{\}\-_\+&„\"\'\.,;\|\%\/\s]', '', value)
        sanitized_string = sanitized_string \
            .replace("'", "\\'")
        return sanitized_string
