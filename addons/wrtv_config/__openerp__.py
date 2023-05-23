# -*- coding: utf-8 -*-

{
    'name': 'wrtv_config',
    'summary': '''FS-Online wrtv instance configuration''',
    'description': '''
FS-Online Instance Configuration
================================

Customer configuration for the instance wrtv

- Default settings
- View modifications
- CSS
- Translations
    ''',
    'author': 'Joachim Grubelnik (joachim.grubelnik@datadialog.net), DataDialog',
    'version': '1.0',
    'website': 'https://www.datadialog.net',
    'installable': True,
    'depends': [
        'sale',
        'portal_sale',
        'website',
        'website_sale_donate',
        'survey',
    ],
    'data': [
        'views/templates.xml',
        'views/snippet_options.xml',
    ],
}