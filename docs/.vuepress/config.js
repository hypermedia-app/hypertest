module.exports = {
    title: 'Testing hypermedia apps',
    description: 'Guides to hypermedia-driven API testing',
    themeConfig: {
        logo: '/assets/icon.png',
        nav: [
            { text: 'Home', link: '/' },
            { text: 'Hypertest DSL', link: '/dsl/' },
        ],
        sidebar: {
            '/dsl': [
                '/dsl/',
                '/dsl/algorithm',
                {
                    title: 'Core grammar',
                    path: '/dsl/core/',
                    collapsable: false,
                    children: [
                        '/dsl/core/class',
                        '/dsl/core/property',
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
