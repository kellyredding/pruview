Feature: Document
  In order have file thumbnails programmatically
  As a user
  I want create document file thumbnails
  
  Scenario: Basic Image thumbnail
    Given I have a basic image document
    When I create a jpg thumbnail
    Then I should have a jpg file

  Scenario: Invalid source image
    Given I have an invalid image document
    Then Pruview should complain about an invalid source file

  Scenario: Invalid output path
    Given I have an invalid output path for documents
    Then Pruview should complain about an invalid output path

  Scenario: Invalid source format
    Given I have an invalid format document
    Then Pruview should complain about an invalid source file format
