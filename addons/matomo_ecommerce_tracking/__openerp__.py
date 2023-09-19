# -*- coding: utf-8 -*-

{
    'name': 'matomo_ecommerce_tracking',
    'summary': '''Matomo E-Commerce tracking''',
    'description': '''
    ''',
    'author': 'DataDialog',
    'version': '0.1',
    'website': 'https://www.datadialog.net',
    'installable': True,
    'depends': [
        'website',
        'fso_base_website',
        'wrtv_config',
    ],
    'data': [
        'views/website_view.xml',
        'views/templates.xml',
    ],
}