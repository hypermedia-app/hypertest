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
                    title: 'Core grammar',
                    path: '/dsl/core/',
                    children: [
                        '/dsl/core/class',
                        '/dsl/core/header',
                        '/dsl/core/link',
                        '/dsl/core/property',
                        '/dsl/core/status',
                    ]
                },
                {
                    title: 'Hydra grammar',
                    path: '/dsl/hydra/',
                    children: [
                        '/dsl/hydra/operation',
                    ]
                }
            ]
        },
        repo: 'hypermedia-app/hypertest',
        docsDir: 'guides',
        editLinks: true,
        editLinkText: 'Edit Page',
        lastUpdated: 'Last Updated',
    }
}
