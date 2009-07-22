Feature: Document
  In order have file thumbnails programmatically
  As a user
  I want create document file thumbnails
  
  Scenario: Basic Image thumbnail
    Given I have a basic image file document
    When I create a jpg thumbnail from that file
    Then I should have a jpg thumbnail

  Scenario: Invalid source image
    Given I have an invalid file document
    Then Pruview should complain about an invalid source file

  Scenario: Invalid output path
    Given I have an invalid output path document
    Then Pruview should complain about an invalid output path

  Scenario: Invalid source format
    Given I have an invalid format file document
    Then Pruview should complain about an invalid source file format

  Scenario: Error 
    Given I have an invalid format file document
    Then Pruview should complain about an invalid source file format
