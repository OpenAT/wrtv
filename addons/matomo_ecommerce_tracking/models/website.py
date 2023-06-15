from openerp import api, models, fields


import logging

logger = logging.getLogger(__name__)


class MatomoEcommerceWebsite(models.Model):
    _inherit = 'website'

    matomo_site_id = fields.Char(string="Matomo Site ID")
    matomo_api_key = fields.Char(string="Matomo API Key")
