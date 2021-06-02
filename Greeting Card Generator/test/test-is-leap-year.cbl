       IDENTIFICATION DIVISION.
           PROGRAM-ID. "test-is-leap-year".
       ENVIRONMENT DIVISION.
           CONFIGURATION SECTION.
           REPOSITORY.
               FUNCTION IS-LEAP-YEAR.
       PROCEDURE DIVISION.

           CALL "assert-equals" USING IS-LEAP-YEAR(2020)'TRUE'
 
           CALL "assert-equals" USING IS-LEAP-YEAR(2021) 'FALSE'.




