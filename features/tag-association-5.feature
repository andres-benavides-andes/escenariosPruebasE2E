Feature: Tag association (Case 5)

  @user1 @web
  Scenario: Associate a tag with a page
    Given I log in ghost local app as an administrator with this user "<EMAIL>" and password "<PASSWORD>"
    Then I create a tag with the name  "testtag", and the description "This is a sample tast"
    Then I create a draf page with the title "My new Page"
    Then I associate the tag "testtag" with the page "My new Page"
    Then I validate that tag "testtag" is associate with a page
    Then I delete the page with the title "My new Page"
    Then I delete the tag with the slug "testtag"