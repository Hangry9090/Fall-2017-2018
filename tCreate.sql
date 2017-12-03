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
INSERT INTO Reservations VALUES (101, TO_DATE('10/10/12', 'MM/DD/YY'),
                                  22, TO_DATE('10/07/12', 'MM/DD/YY'));
INSERT INTO Reservations VALUES (102, TO_DATE('10/14/12', 'MM/DD/YY'),
                                  22, TO_DATE('10/10/12', 'MM/DD/YY'));
INSERT INTO Reservations VALUES (103, TO_DATE('11/17/12', 'MM/DD/YY'),
                                  22, TO_DATE('10/10/12', 'MM/DD/YY'));
INSERT INTO Reservations VALUES (105, TO_DATE('10/14/12', 'MM/DD/YY'),
                                  58, TO_DATE('10/13/12', 'MM/DD/YY'));
INSERT INTO Reservations VALUES (102, TO_DATE('10/20/12', 'MM/DD/YY'),
                                  31, TO_DATE('10/10/12', 'MM/DD/YY'));
INSERT INTO Reservations VALUES (103, TO_DATE('11/22/12', 'MM/DD/YY'),
                                  31, TO_DATE('10/20/12', 'MM/DD/YY'));
INSERT INTO Reservations VALUES (104, TO_DATE('11/23/12', 'MM/DD/YY'),
                                  31, TO_DATE('10/20/12', 'MM/DD/YY'));
INSERT INTO Reservations VALUES (101, TO_DATE('09/05/12', 'MM/DD/YY'),
                                  64, TO_DATE('08/27/12', 'MM/DD/YY'));
INSERT INTO Reservations VALUES (102, TO_DATE('11/20/12', 'MM/DD/YY'),
                                  64, TO_DATE('11/03/12', 'MM/DD/YY'));
INSERT INTO Reservations VALUES (103, TO_DATE('10/18/12', 'MM/DD/YY'),
                                  74, TO_DATE('08/04/12', 'MM/DD/YY'));
-- --------------------------------------------------------------------
INSERT INTO Sailors VALUES (22, 'Dave', 7, 45.0, 85);
INSERT INTO Sailors VALUES (29, 'Mike', 1, 33.0,NULL);
INSERT INTO Sailors VALUES (31, 'Mary', 8, 55.0, 85);
INSERT INTO Sailors VALUES (32, 'Albert', 8, 25.0, 31);
INSERT INTO Sailors VALUES (58, 'Jim', 10, 35.0, 32);
INSERT INTO Sailors VALUES (64, 'Jane', 7, 35.0, 22);
INSERT INTO Sailors VALUES (71, 'Dave', 10, 16.0, 32);
INSERT INTO Sailors VALUES (74, 'Jane', 9, 40.0, 95);
INSERT INTO Sailors VALUES (85, 'Art', 3, 25.0, 29);
INSERT INTO Sailors VALUES (95, 'Jane', 3, 63.0, NULL);
-- --------------------------------------------------------------------
INSERT INTO Boats VALUES (101,'Interlake', 'blue', 350, 30, 95);
INSERT INTO Boats VALUES (102, 'Interlake', 'red', 275, 23, 22);
INSERT INTO Boats VALUES (103, 'Clipper', 'green', 160, 15, 85);
INSERT INTO Boats VALUES (104, 'Marine', 'red', 195, 24, 22);
INSERT INTO Boats VALUES (105, 'Weekend Rx', 'white', 500, 43, 31);
INSERT INTO Boats VALUES (106, 'C#', 'red', 300, 27, 32);
INSERT INTO Boats VALUES (107, 'Bayside', 'white', 350, 32, 85);
INSERT INTO Boats VALUES (108, 'C++', 'blue', 100, 12, 95);
-- --------------------------------------------------------------------
-- Now, if no violations were detected, COMMIT all the commands in this file
COMMIT;