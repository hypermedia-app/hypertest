package app.hypermedia.testing.dsl.tests.hydra

class TestCases {
    static def validUris() {
        return #[
            "http://xmlns.com/foaf/0.1/",
            "urn:valid:urn",
            "mailto:dsl@example.com"
        ]
    }
    
    static def invalidUris() {
        return #[
            "not-a-URI",
            "12345"
        ]
    }
}