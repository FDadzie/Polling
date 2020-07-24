Original App Design Project - README Template
===

# Hall of Polls 

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)

## Overview
### Description
This app allows users to vote on game polls. The games used in the polls are then used to set up a tier list of sorts to display in one page and show which game tends to be voted on by users.

### App Evaluation

- **Category:** Entertainment
- **Mobile:** This product is designed to be something that a user can partake in if they find themselves with a little free time.
- **Story:** Users get a general idea as to how most gamers feel about certain games
- **Market:** Gamers (Casual, Hardcore, Enthusiasts)
- **Habit:** Users can participate in as many polls that they feel necessary.
- **Scope:** The focus of this app for now is allow for gamers to have a place where they can vote to give their opinions and go into chats to discuss those opinions. The long-term goal is to include more than games (i.e. movies, books, tv-shows, etc.)

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* [ ] User can sign up to make an account
* [ ] User is alerted when their account username/password is incorrect
* [ ] User can create a poll to be viewed by others
* [ ] User can vote on a poll that was created
* [ ] User can select their prefered genre of game polls
* [ ] User can pull to refresh the home view
* [ ] "All-time" popular games in the app can be viewed
* [ ] User can look at a detailed view of games from the "Popular Games" screen
* [ ] User can long press a cell to look at a detailed view of a game from the "Popular Games" screen
* [ ] User can adjust ther profile page in Settings


**Optional Nice-to-have Stories**

* [ ] User account is persisted when app restarts
* [ ] Users can like the polls that they see on "Home"
* [ ] User can infinitely scroll home page and Game picker
* [ ] Profiles of other users can be viewed by tapping on their profile image from the homescreen
* [ ] The games on "Popular Games" can be filtered out based on genre
* [ ] Messages can be sent privately to other users
* [ ] Push notifications for the ending of polls you have voted created and chatroom messages
* [ ] User can send messages to a group to be view by other users
* [ ] Polls in 'Home' can be filtered out based on genre
* [ ] User can adjust notification settings in Settings

### 2. Screen Archetypes

* Login
   * User can create an account using the "sign up" button
   * User can login to their account using the "log in" button
* Home
   * Updates with polls based on user's preferences
* Popular Games
    * Updates with what games are being used the most for polls
* Poll View
   * Allows the user to look at their created polls and how others have voted on them
* Poll Creation
    * User can create their own poll
* Game Picker
    * User can pick a game from a list of names
* Messaging
    * Chat room that can be viewed by all and allows for interaction between users
* Profile
    * User can look at their current genre preferences
* Settings
    * User can adjust their poll preference for use on homescreen feed

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home
* Poll Creation
* Messaging
* Profile

**Flow Navigation** (Screen to Screen)

* Home
    * Popular Games
      * Game Detail View
* Poll View
   * Poll Creation 
      * Game Picker
* Profile
   * Settings

## Wireframes

<img src=https://github.com/FDadzie/Polling/blob/master/Hall%20of%20Polls%20Images/Hall%20of%20Polls%20(Wireframe).jpg width="600" title="Hall of Polls Wireframe">

(May edit...)

# Schema
### Models

Game

| Property       | Type          | Description  |
| ------------- |:-------------:| -----|
| gameId      | String        |unique Id for the game|
| poll        | Pointer to poll| polls that the game has been used in|
| name        | String        |unique name for the game|
| developers  | Array         |list of developers that worked on the game |
| publishers  | Array         |list of publishers that released the game  |
| platforms   | Array         |list of platforms that game can be played on |
| desc        | String        |description of the game      |
| backgroundImg| File         |background image of the game |
| genres       | Array         |categories that the game belongs in |

User
| Property   | Type           | Description   |
|------------|:--------------:|:-----------|
| userId     | String        | unique Id for the user|
| polls      | Array (Pointer to Polls)| polls that the user has created|
| userName   | String        | the name of the current user|
| favGame    | Array         | the favorite game of the user|
| prefGenre  | Array         | preferred genres of the user|


Poll
| Property   | Type           | Description   |
|------------|:--------------:|:--------------|
| pollId     | String         | unique Id for the poll|
| pollCreator| Pointer to User| creator of the poll|
| totalVoteCount| Number      | total amount of votes on the given poll|
| optionCount   | Number      | total of given options for users to vote on|
| isOpen     | Boolean        | determines if the poll is still open to votes|
| options    | Array          | Choices that users can vote on|
| pollQuestion| String        | guiding question of the poll|



### Networking

**[Optional]: Existing API endpoints**

**RAWG API**
* Base URL -  https://api.rawg.io/api

| HTTP Verb      | Endpoint         | Description  |
| ------------- |:-------------:| -----|
| GET           | /creator-roles |Get a list of creator positions (jobs)|
| GET           | /creators      |Get a list of game creators|
| GET           | /developers    |Get a list of game developers|
| GET           | /games         |Get a list of games|
| GET           | /genres        |Get a list of video game genres|
| GET           | /platforms     |Get a list of video game platforms|
| GET           | /publishers    |Get a list of video game publishers|
| GET           | /stores        |Get a list of video game storefronts|
| GET           | /tags          |Get a list of tags|
