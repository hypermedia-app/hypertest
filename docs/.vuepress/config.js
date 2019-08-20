module.exports = {
    title: 'Testing hypermedia apps',
    description: 'Guides to hypermedia-driven API testing',
    themeConfig: {
        logo: '/assets/icon.png',
        nav: [
            { text: 'Home', link: '/' },
            { text: 'Hypertest DSL', link: '/dsl/' },
            { text: 'Tools', link: '/tools/' },
            { text: 'Web Editor', link: 'http://hypertest.kube.zazuko.com' },
        ],
        sidebar: {
            '/dsl': [
                '/dsl/',
                '/dsl/algorithm',
                {
                    title: 'Core steps',
                    path: '/dsl/core/',
                    collapsable: false,
                    children: [
                        '/dsl/core/class',
                        '/dsl/core/follow',
                        '/dsl/core/header',
                        '/dsl/core/link',
                        '/dsl/core/property',
                        '/dsl/core/status',
                    ]
                },
                {
                    title: 'Hydra steps',
                    path: '/dsl/hydra/',
                    collapsable: false,
                    children: [
                        '/dsl/hydra/invoke',
                        '/dsl/hydra/operation',
                        '/dsl/hydra/prefix',
                        '/dsl/hydra/type',
                    ]
                },
                '/dsl/constrained-blocks',
            ]
        },
        repo: 'hypermedia-app/hypertest',
        docsDir: 'guides',
        editLinks: true,
        editLinkText: 'Edit Page',
        lastUpdated: 'Last Updated',
    }
}
