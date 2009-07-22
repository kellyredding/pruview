Feature: Video Image
  In order have video image thumbnails programmatically
  As a user
  I want create video image file thumbnails
  
  Scenario: Basic Image thumbnail
    Given I have a basic video video image jpg
    Then I should have a jpg file

  Scenario: Invalid source image
    Given I have an invalid video video image jpg
    Then Pruview should complain about an invalid source file

  Scenario: Invalid output path
    Given I have an invalid output path for video images
    Then Pruview should complain about an invalid output path

  Scenario: Invalid source format
    Given I have an invalid format video image jpg
    Then Pruview should complain about an invalid source file format
