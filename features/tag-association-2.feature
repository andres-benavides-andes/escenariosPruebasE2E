Feature: Tag association (Case 2)

  @user1 @web
  Scenario: Associate 3 tags to a post
    Given I log in ghost local app as an administrator with this user "<EMAIL>" and password "<PASSWORD>"
    Then I create a tag with the name  "testtag1", and the description "This is the tag 1"
    Then I create a tag with the name  "testtag2", and the description "This is the tag 2"
    Then I create a tag with the name  "testtag3", and the description "This is the tag 3"
    Then I create a draf post with the title "My testing 2"
    Then I associate the tag "testtag1" with the post "My testing 2"
    Then I associate the tag "testtag2" with the post "My testing 2"
    Then I associate the tag "testtag3" with the post "My testing 2"
    Then I validate that tag "testtag1" is associate with the post "My testing 2"
    Then I validate that tag "testtag2" is associate with the post "My testing 2"
    Then I validate that tag "testtag3" is associate with the post "My testing 2"
    Then I delete the post with the title "My testing 2"
    Then I delete the tag with the slug "testtag1"
    Then I delete the tag with the slug "testtag2"
    Then I delete the tag with the slug "testtag3"