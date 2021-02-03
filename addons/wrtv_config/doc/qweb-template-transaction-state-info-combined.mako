
Betreff: ${('Christkind' if object.cat_root_id.id == 5 or object.cat_root_id.id == 6 or object.cat_root_id.id == 7 or object.cat_root_id.id == 8 else 'Vielen Dank für Ihre tierliebe Unterstützung!')}

<div style="font-family: Arial, Verdana, sans-serif; font-size: 14px;">
<% set linecounterwrtv = 0 %>
<% set FirstTimeOnlyChristmas = 0 %>
<% set FirstTimeOnlyDonation = 0 %>
<% set Spendensumme = 0 %>

% for so_line in object.order_line or '':
    <% set linecounterwrtv = linecounterwrtv + 1 %>
        ##linecounter: ${linecounterwrtv}
    % if so_line.product_id.default_code
        ##FirstTimeOnlyChristmasVarOutside: ${FirstTimeOnlyChristmas}
        % if FirstTimeOnlyChristmas == 0
            ##FirstTimeOnlyChristmasVarInside: ${FirstTimeOnlyChristmas}
            <p>
            % if object.partner_id.gender == 'male'
                Lieber Tierfreund!
            % elif object.partner_id.gender == 'female'
                Liebe Tierfreundin!
            % elif object.partner_id.gender == 'other'
            Hallo TierfreundIn!
            % endif
            </p>
            Wir freuen uns, dass Sie an unserer Christkindaktion teilnehmen und

            % for so_line in object.order_line:
                % if so_line.product_id.default_code
                    <strong>${so_line.product_id.name or ''} </strong>
                % endif
            % endfor
            werden!
            <p>
            <strong style="font-size: 18px;color:#dc0000;">Ihr Schützling freut sich zu Weihnachten über:</strong>
            </p>
            % for so_line in object.order_line:
                % if so_line.product_id.default_code
                    <strong>${so_line.product_id.description_sale or ''} </strong>
                % endif
            % endfor
            <p></p>
            Besorgen Sie eine, mehrere oder sogar alle Wünsche von der Liste, schnüren Sie ein Paket und beschriften<br>
            Sie es vollständig mit dem Namen Ihres Schützlings und der entsprechenden Protokoll-Nummer.<br>
            Diese Nummer hilft uns dabei, die Geschenke im Tierschutzhaus an die richtigen Stellen zu<br>
            verteilen.
            <p></p>
            <p><strong>Die Daten, um Ihr Etikett zu beschriften, sowie unsere Adresse
            finden Sie hier:</strong></p>
            <p>
            ---------------------------------------------------------------------------<br>
            <strong>CHRISTKIND-AKTION</strong><br>
            Tier:
            % for so_line in object.order_line:
                % if so_line.product_id.default_code
                    ${so_line.product_id.name or ''}
                % endif
            % endfor
            <br>
            Protokollnummer:
            % for so_line in object.order_line:
                % if so_line.product_id.default_code
                    ${so_line.product_id.default_code or ''}
                % endif
            % endfor
            <br>
            <strong>Wiener Tierschutzverein</strong><br>
            Triester Straße 8<br>
            2331 Vösendorf<br>
            ---------------------------------------------------------------------------<br>
            Hier finden Sie Wunschliste, Paketetikett und Gutscheine zum Download:
            % for line in object.order_line:
                % if so_line.product_id.default_code
                    % if line.product_id.webshop_download_file:
                         </p><p></p><div><a href="/web/binary/saveas?model=product.product&amp;field=webshop_download_file&amp;filename_field=webshop_download_file_name&amp;id=${line.product_id.id}" style="color:#dc0000;">Download</a></div>
                    % endif
                    % if line.product_tmpl_id.webshop_download_file:
                        <div><a href="/web/binary/saveas?model=product.template&amp;field=webshop_download_file&amp;filename_field=webshop_download_file_name&amp;id=${line.product_tmpl_id.id}" style="color:#dc0000;">Download</a></div>
                    % endif
                % endif
            % endfor
            <p>
                <br>Ihr Weihnachtsgeschenk können Sie entweder persönlich in unserem Foyer abgeben <br>oder per Post an uns schicken.</p>
                <p>
            Wir bitten um Verständnis, dass es aus organisatorischen Gründen nicht möglich ist, das Paket<br>
            direkt zum Tier zu bringen. Bei der persönlichen Übergabe bitten wir zudem um das<br>
            Tragen eines Mund-Nasen-Schutzes sowie die Einhaltung des gesetzlichen Sicherheitsabstands<br>
            von mindestens einem Meter.
                </p>
            <p>
            Bei Fragen steht Ihnen unser Christkind-Büro telefonisch unter +43 1 699 24 50 – Durchwahl 18<br>
            oder 19 oder per E-Mail unter christkind@tierschutz-austria.at zur Verfügung.<br>
            Telefonate und E-Mails werden im Aktionszeitraum von <strong>Montag bis Donnerstag, jeweils von 9<br>
            bis 16 Uhr, beantwortet.</strong>
            </p>
            <p>Wir bedanken uns im Namen unserer tierischen Schützlinge und wünschen ein besinnliches Weihnachtsfest! </p><br><br>
        % endif
        <% set FirstTimeOnlyChristmas = FirstTimeOnlyChristmas + 1 %>
    % else
        % if FirstTimeOnlyDonation == 0
            <h2>
            % if object.partner_id.gender == 'male'
                Lieber Herr
            % elif object.partner_id.gender == 'female'
                Liebe Frau
            % elif object.partner_id.gender == 'other'
                Hallo
            % endif
                ${object.partner_id.lastname or ''},</h2><br>
                vielen Dank für Ihr Vertrauen und Ihre großzügige Unterstützung für Tiere in Not!<br>
                Nur durch Ihre Hilfe ist uns unser Einsatz für Tiere möglich.
                <p>Wir bedanken uns ganz herzlich! <br><br>
                Bei Fragen können Sie uns gerne kontaktieren - unser Spendenservice-Team steht Ihnen unter <br>
                <strong>spendenservice@tierschutz-austria.at</strong> oder telefonisch unter <strong>01 699 24 50 - 19</strong> oder <strong>18</strong> zur Verfügung. <br>
                Unsere Telefonzeiten sind Montag bis Donnerstag von 9 bis 16 Uhr sowie Freitag von 9 bis 13 Uhr.<br></p>
                Ihre Zuwendung bedeutet uns daher sehr viel.
                <h3><br>Bitte überprüfen Sie Ihre angegebenen Daten auf Ihre Richtigkeit:</h3>
                <p>
            % if object.partner_id.name:
                ${object.partner_id.name}<br>
            % endif
            % if object.partner_id.street:
                ${object.partner_id.street or ''} ${object.partner_id.street_number_web or ''}<br>
            % endif
            % if object.partner_id.street2:
                ${object.partner_id.street2}<br>
            % endif
            % if object.partner_id.city or object.partner_id.zip:
                ${object.partner_id.zip} ${object.partner_id.city}<br>
            % endif
            % if object.partner_id.email:
                E-Mail:&nbsp;<a style="color:#dc0000;" href="mailto:${object.partner_id.email}">${object.partner_id.email}</a><br>
            % endif

         </p>
        <h3><br>Zahlungsübersicht:&nbsp;</h3>
        <p style="padding-left: 14px;">
            Transaktionsnummer:
                % if not so_line.product_id.default_code
                    <strong>${object.name}</strong>
                % endif
                <br>Gesamtsumme:
                    % if not so_line.product_id.default_code
                         ## <% Spendensumme = Spendensumme + line.price_unit %>
                        ${object.amount_total}
                    % endif
                ${object.pricelist_id.currency_id.name}
                <br>Datum:
                % if not so_line.product_id.default_code
                    ${format_tz(object.date_order, tz='Europe/Vienna', format='%Y-%m-%d %H:%M')}
                % endif
                <br>Status:
                % if not so_line.product_id.default_code
                    <strong style="text-transform:uppercase;">${object.payment_tx_id.state or '?'}</strong>
                % endif
            </p>
        % endif
        <% set FirstTimeOnlyDonation = FirstTimeOnlyDonation + 1 %>
    % endif
% endfor
    <h3>
        <strong>${object.company_id.name}<br>
        Die Stimme der Tiere. Seit 1846.</strong></h3>
    <p>
        Wiener Tierschutzverein<br>
        % if object.company_id.street:
            ${object.company_id.street}<br>
        % endif
        % if object.company_id.street2:
            ${object.company_id.street2}<br>
        % endif
        % if object.company_id.city or object.company_id.zip:
            ${object.company_id.zip} ${object.company_id.city}<br>
        % endif
        % if object.company_id.country_id:
            ${object.company_id.state_id and ('%s, ' % object.company_id.state_id.name) or ''} ${object.company_id.country_id.name or ''}<br>
        % endif
        % if object.company_id.website:
            <a style="color:#dc0000;" href="${object.company_id.website}">${object.company_id.website}</a><br>
        % endif
        % if object.company_id.logo:
            </p><div style="padding:0; margin:0;"><img src="data:image/png;base64,${object.company_id.logo}" style="width: 120px;"></div>
        % endif
    <p style="font-size:11px;">Tierschutz Austria ist eine Wort-Bildmarke des Wiener Tierschutzvereins. Der Wiener Tierschutzverein ist Träger<br>
des Österreichischen Spendegütesiegels. Dieses garantiert Ihnen die zweckmäßige Verwendung Ihrer Spenden.</p>

</div>

