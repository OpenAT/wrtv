# -*- coding: utf-8 -*-

from openerp import api, fields, models

import logging
logger = logging.getLogger(__name__)


class ResPartnerAbsenceNotice(models.Model):
    _inherit = 'res.partner'

    absent_until = fields.Date(string="Absent until")
    stand_in_name = fields.Char(string="Stand-in name")
    stand_in_email = fields.Char(string="Stand-in email")

    def create_absence_notice_mail_message(self, partner, values):
        line1 = values.get('absent_until', False)
        line2 = values.get('stand_in_name', False)
        line3 = values.get('stand_in_email', False)

        if line1 or line2 or line3:
            message_body = (line1.isoformat().replace("T00:00:00", "") if line1 else "") + "\n-----\n" +\
                           (line2 if line2 else "") + "\n-----\n" +\
                           (line3 if line3 else "") + "\n-----\n" +\
                           "Abwesenheitsnotiz"

            logger.debug("Found absence notice fields (\"%s\", \"%s\", \"%s\"). Creating mail.message"
                         % (line1, line2, line3))

            partner.sudo().with_context(mail_post_autofollow=False).message_post(
                body=message_body,
                type='comment',
                subtype='fso_mail_message_subtypes_absence_notice.fson_absence_notice',
                content_subtype="plaintext")

    @api.model
    def create(self, values):
        partner = super(ResPartnerAbsenceNotice, self).create(values)
        self.create_absence_notice_mail_message(partner, values)
        return partner

    @api.multi
    def write(self, values):
        res = super(ResPartnerAbsenceNotice, self).write(values)

        for p in self:
            self.create_absence_notice_mail_message(p, values)

        return res
