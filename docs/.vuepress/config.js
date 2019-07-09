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
                    path: '/dsl/steps/',
                    title: 'Scenario steps',
                    collapsable: false,
                    children: [
                        '/dsl/steps/class',
                        '/dsl/steps/property',
                        '/dsl/steps/expect'
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
