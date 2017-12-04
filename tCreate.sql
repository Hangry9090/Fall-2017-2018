/*
CIS 353
 - Database Design Project 
Marshal Brummel
Nolan Gustafson
Matthew Tetreau
Tim VanDyke
*/
-- CREATING THE TABLES
-- --------------------------------------------------------------------
CREATE TABLE  Players
(
playerID    INTEGER,
name        CHAR(50)    NOT NULL, 
iGN         CHAR(50)    NOT NULL,
age         NUMBER(4,1) NOT NULL,
teamID      INTEGER     NOT NULL,   
startDate   DATE        NOT NULL,
endDate     DATE,       /*null means they are still playing*/
    
    
-- plyrIC1: Player Ids are unique
CONSTRAINT plyrIC1 PRIMARY KEY (playerID),
-- plyrIC2: Players must be 17 or older
CONSTRAINT plyrIC2 CHECK (age >= 17),
-- plyrIC3: players must be on a team
CONSTRAINT plyrIC3 FOREIGN KEY (teamID) REFERENCES Team(teamID)
            ON DELETE CASCADE
            DEFERRABLE INITIALLY DEFERRED,
    
);
-- -------------------------------------------------------------------
CREATE TABLE  Teams
(
teamID      INTEGER,
teamName    CHAR(50)  NOT NULL,

    
-- tIC1: Team Ids are unique.
CONSTRAINT tIC1 PRIMARY KEY (teamID),

);
-- --------------------------------------------------------------------
CREATE TABLE  Coaches
(
coachID     INTEGER, 
teamID      INTEGER   NOT NULL,
name        CHAR(50)  NOT NULL,
startDate   DATE        NOT NULL,
endDate     DATE,       /*null means they are still playing*/
    
    
-- cIC1: Coach IDs are unique.
CONSTRAINT cIC1 PRIMARY KEY (coachID),
-- cIC2: a coach's team must exist
CONSTRAINT cIC2 FOREIGN KEY (teamID) REFERENCES Team(teamID)
            ON DELETE SET NULL
            DEFERRABLE INITIALLY DEFERRED,
    
);
-- ------------------------------------------------------------------
CREATE TABLE  Tournaments
(
tournamentID   INTEGER, 
name           CHAR(50)  NOT NULL,
tDate          DATE      NOT NULL,    
prizePool      INTEGER   NOT NULL,

    
    
-- trnIC1: tournament IDs are unique
CONSTRAINT trnIC1 PRIMARY KEY (tournamentID),

);

-- ------------------------------------------------------------------
CREATE TABLE  SocialMedia
(
playerID       INTEGER, 
handle         CHAR(50)  NOT NULL,
platform       CHAR(50)  NOT NULL,

    
-- smIC1: player with social media have to have a handle
CONSTRAINT smIC1 PRIMARY KEY (playerID, handle),
-- smIC2: a handle must belong to a player that exists
CONSTRAINT smIC2 FOREIGN KEY (playerID) REFERENCES Players(playerID)
            ON DELETE CASCADE
            DEFERRABLE INITIALLY DEFERRED,
-- smIC3: handles for Twitter accounts must start with a '@'
CONSTRAINT smIC3 CHECK (NOT(platform = 'Twitter' and handle != '@%')),
    
    
                    /** Check if smIC3 looks correct pls**/
);
-- ------------------------------------------------------------------
CREATE TABLE  ParticipateIn
(
tournamentID   INTEGER, 
teamID         INTEGER,
result         INTEGER  NOT NULL,

    
-- prtIC1: teams participate in any given tournament only once
CONSTRAINT prtIC1 PRIMARY KEY (tournamentID, teamID),
-- prtIC2: the tournament must exist
CONSTRAINT prtIC2 FOREIGN KEY (tournamentID) REFERENCES Tournaments(tournamentID)
            ON DELETE CASCADE
            DEFERRABLE INITIALLY DEFERRED,
-- prtIC3: the team must exist
CONSTRAINT prtIC3 FOREIGN KEY (teamID) REFERENCES Players(teamID)
            ON DELETE CASCADE
            DEFERRABLE INITIALLY DEFERRED,
     
);
-- ------------------------------------------------------------------
CREATE TABLE  PreferredChamps
(
playerID          INTEGER, 
champName         INTEGER,

     
-- pcIC1: players can have multiple preferred champs
CONSTRAINT pcIC1 PRIMARY KEY (playerID, champName),
-- pcIC2: the player must actually exist
CONSTRAINT pcIC2 FOREIGN KEY (playerID) REFERENCES Players(playerID)
            ON DELETE CASCADE
            DEFERRABLE INITIALLY DEFERRED,
    
);

-- --------------------------------------------------------------------
-- POPULATING THE DATABASE INSTANCE
-- --------------------------------------------------------------------
INSERT INTO Players VALUES (101, 'James', 'JamesCarries', 25, 01, TO_DATE('10/10/12', 'MM/DD/YY'), TO_DATE('10/07/12', 'MM/DD/YY'));
INSERT INTO Players VALUES (102, 'Noah', 'ILoveDogs', 20, 01, TO_DATE('10/14/12', 'MM/DD/YY'), TO_DATE('10/10/12', 'MM/DD/YY'));
INSERT INTO Players VALUES (103, 'Janelle', 'Jhinelle', 18, 01, TO_DATE('11/17/12', 'MM/DD/YY'), TO_DATE('10/10/12', 'MM/DD/YY'));
INSERT INTO Players VALUES (104, 'Mason', 'StoneMason', 21,  01, TO_DATE('10/14/12', 'MM/DD/YY'), TO_DATE('10/13/12', 'MM/DD/YY'));
INSERT INTO Players VALUES (105, 'Jacob', 'Durt', 22, 01, TO_DATE('10/20/12', 'MM/DD/YY'), TO_DATE('10/10/12', 'MM/DD/YY'));
INSERT INTO Players VALUES (106, 'William', 'Bill', 19, 02, TO_DATE('11/22/12', 'MM/DD/YY'), TO_DATE('10/20/12', 'MM/DD/YY'));
INSERT INTO Players VALUES (107, 'Ethan', 'Schafey', 26, 02, TO_DATE('11/23/12', 'MM/DD/YY'), TO_DATE('10/20/12', 'MM/DD/YY'));
INSERT INTO Players VALUES (108, 'Alexander', 'TheConqueror', 24, 02, TO_DATE('09/05/12', 'MM/DD/YY'), TO_DATE('08/27/12', 'MM/DD/YY'));
INSERT INTO Players VALUES (109, 'Michael', 'Scotty', 36, 02, TO_DATE('11/20/12', 'MM/DD/YY'), TO_DATE('11/03/12', 'MM/DD/YY'));
INSERT INTO Players VALUES (110, 'Benjamin', 'Benji', 20, 02, TO_DATE('10/18/12', 'MM/DD/YY'), TO_DATE('08/04/12', 'MM/DD/YY'));
INSERT INTO Players VALUES (111, 'Elijah', 'RavenBeggar', 29, 03, TO_DATE('10/10/12', 'MM/DD/YY'), TO_DATE('10/07/12', 'MM/DD/YY'));
INSERT INTO Players VALUES (112, 'Aiden', 'aidaneb04', 30, 03, TO_DATE('10/14/12', 'MM/DD/YY'), TO_DATE('10/10/12', 'MM/DD/YY'));
INSERT INTO Players VALUES (113, 'Nolan', 'Destroyer', 31, 03, TO_DATE('11/17/12', 'MM/DD/YY'), TO_DATE('10/10/12', 'MM/DD/YY'));
INSERT INTO Players VALUES (114, 'Daniel', 'lionTamer', 26, 03, TO_DATE('10/14/12', 'MM/DD/YY'), TO_DATE('10/13/12', 'MM/DD/YY'));
INSERT INTO Players VALUES (115, 'Matt', 'TaxCollector', 35, 03, TO_DATE('10/20/12', 'MM/DD/YY'), TO_DATE('10/10/12', 'MM/DD/YY'));
-- --------------------------------------------------------------------
INSERT INTO Teams VALUES (01, 'Cloud9');
INSERT INTO Teams VALUES (02, 'TeamSoloMid');
INSERT INTO Teams VALUES (03, 'EchoFox');
-- --------------------------------------------------------------------
INSERT INTO Coaches VALUES (01, 01, 'Tim', TO_DATE('10/20/12', 'MM/DD/YY'), TO_DATE('10/10/12', 'MM/DD/YY'));
INSERT INTO Coaches VALUES (02, 01, 'Matt', TO_DATE('10/20/12', 'MM/DD/YY'), TO_DATE('10/10/12', 'MM/DD/YY'));
INSERT INTO Coaches VALUES (03, 01, 'Marshal', TO_DATE('10/20/12', 'MM/DD/YY'), TO_DATE('10/10/12', 'MM/DD/YY'));
-- --------------------------------------------------------------------
INSERT INTO Tournaments VALUES (101,'Winter_Finals', TO_DATE('03/10/15', 'MM/DD/YY'), 50000);
INSERT INTO Tournaments VALUES (101,'Spring_Finals', TO_DATE('06/10/15', 'MM/DD/YY'), 40000);
INSERT INTO Tournaments VALUES (101,'Summer_Finals', TO_DATE('09/10/15', 'MM/DD/YY'), 80000);
INSERT INTO Tournaments VALUES (101,'Worlds', TO_DATE('12/15/15', 'MM/DD/YY'), 100000);
INSERT INTO Tournaments VALUES (101,'Winter_Finals', TO_DATE('03/10/16', 'MM/DD/YY'), 60000);
INSERT INTO Tournaments VALUES (101,'Spring_Finals', TO_DATE('06/10/16', 'MM/DD/YY'), 50000);
INSERT INTO Tournaments VALUES (101,'Summer_Finals', TO_DATE('09/10/16', 'MM/DD/YY'), 90000);
INSERT INTO Tournaments VALUES (101,'Worlds', TO_DATE('12/15/16', 'MM/DD/YY'), 110000);
INSERT INTO Tournaments VALUES (101,'Winter_Finals', TO_DATE('03/10/17', 'MM/DD/YY'), 70000);
INSERT INTO Tournaments VALUES (101,'Spring_Finals', TO_DATE('06/10/17', 'MM/DD/YY'), 60000);
INSERT INTO Tournaments VALUES (101,'Summer_Finals', TO_DATE('09/10/17', 'MM/DD/YY'), 100000);
INSERT INTO Tournaments VALUES (101,'Worlds', TO_DATE('12/15/17', 'MM/DD/YY'), 120000);
-- --------------------------------------------------------------------
INSERT INTO SocialMedia VALUES (101, 'C9James', 'YouTube');
INSERT INTO SocialMedia VALUES (101, 'JamesStream', 'Twitch');
INSERT INTO SocialMedia VALUES (101, '@C9James', 'Twitter');
INSERT INTO SocialMedia VALUES (102, 'C9Noah', 'YouTube');
INSERT INTO SocialMedia VALUES (102, 'NoahStream', 'Twitch');
INSERT INTO SocialMedia VALUES (102, '@C9Noah', 'Twitter');
INSERT INTO SocialMedia VALUES (103, 'C9Janelle', 'YouTube');
INSERT INTO SocialMedia VALUES (103, 'JanelleStream', 'Twitch');
INSERT INTO SocialMedia VALUES (103, '@C9Janelle', 'Twitter');
INSERT INTO SocialMedia VALUES (104, 'C9Mason', 'YouTube');
INSERT INTO SocialMedia VALUES (104, 'MasonStream', 'Twitch');
INSERT INTO SocialMedia VALUES (104, '@C9Mason', 'Twitter');
INSERT INTO SocialMedia VALUES (105, 'C9Jacob', 'YouTube');
INSERT INTO SocialMedia VALUES (105, 'JacobStream', 'Twitch');
INSERT INTO SocialMedia VALUES (105, '@C9Jacob', 'Twitter');
INSERT INTO SocialMedia VALUES (106, 'TMSWilliam', 'YouTube');
INSERT INTO SocialMedia VALUES (106, 'WilliamStream', 'Twitch');
INSERT INTO SocialMedia VALUES (106, '@TSMWIlliam', 'Twitter');
INSERT INTO SocialMedia VALUES (107, 'TSMEthan', 'YouTube');
INSERT INTO SocialMedia VALUES (107, 'EthanStream', 'Twitch');
INSERT INTO SocialMedia VALUES (107, '@TSMEthan', 'Twitter');
INSERT INTO SocialMedia VALUES (108, 'TSMAlexander', 'YouTube');
INSERT INTO SocialMedia VALUES (108, 'AlexanderStream', 'Twitch');
INSERT INTO SocialMedia VALUES (108, '@TSMAlexander', 'Twitter');
INSERT INTO SocialMedia VALUES (109, 'TSMMichael', 'YouTube');
INSERT INTO SocialMedia VALUES (109, 'MichaelStream', 'Twitch');
INSERT INTO SocialMedia VALUES (109, '@TSMMichael', 'Twitter');
INSERT INTO SocialMedia VALUES (110, 'TSMBenjamin', 'YouTube');
INSERT INTO SocialMedia VALUES (110, 'BenjaminStream', 'Twitch');
INSERT INTO SocialMedia VALUES (110, '@TSMBenjamin', 'Twitter');
INSERT INTO SocialMedia VALUES (111, 'ECFElijah', 'YouTube');
INSERT INTO SocialMedia VALUES (111, 'ElijahStream', 'Twitch');
INSERT INTO SocialMedia VALUES (111, '@ECFElijah', 'Twitter');
INSERT INTO SocialMedia VALUES (112, 'ECFAiden', 'YouTube');
INSERT INTO SocialMedia VALUES (112, 'AidenStream', 'Twitch');
INSERT INTO SocialMedia VALUES (112, '@ECFAidenStream', 'Twitter');
INSERT INTO SocialMedia VALUES (113, 'ECFNolan', 'YouTube');
INSERT INTO SocialMedia VALUES (113, 'NolanStream', 'Twitch');
INSERT INTO SocialMedia VALUES (113, '@ECFNolan', 'Twitter');
INSERT INTO SocialMedia VALUES (114, 'ECFDaniel', 'YouTube');
INSERT INTO SocialMedia VALUES (114, 'DanielStream', 'Twitch');
INSERT INTO SocialMedia VALUES (114, '@ECFDaniel', 'Twitter');
INSERT INTO SocialMedia VALUES (115, 'ECFMatt', 'YouTube');
INSERT INTO SocialMedia VALUES (115, 'MattStream', 'Twitch');
INSERT INTO SocialMedia VALUES (115, '@ECFMatt', 'Twitter');
-- --------------------------------------------------------------------
INSERT INTO ParticipateIn VALUES (101,'Interlake', 'blue', 350, 30, 95);
-- --------------------------------------------------------------------
INSERT INTO Preferred Champs VALUES (101,'Interlake', 'blue', 350, 30, 95);
-- --------------------------------------------------------------------
-- Now, if no violations were detected, COMMIT all the commands in this file
COMMIT;
