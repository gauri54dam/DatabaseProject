USE DAMG6210_Team1;

/*
CODE FOR CREATING ENCRYPTION KEY (ONLY NEED TO RUN ONE TIME IN DB)
-- Create DMK
CREATE MASTER KEY
ENCRYPTION BY PASSWORD = 'Test_P@sswOrd';
-- Create certificate to protect symmetric key
CREATE CERTIFICATE TestCertificate
WITH SUBJECT = 'DAMG Certificate',
EXPIRY_DATE = '2026-10-31';
-- Create symmetric key to encrypt data
CREATE SYMMETRIC KEY TestSymmetricKey
WITH ALGORITHM = AES_128
ENCRYPTION BY CERTIFICATE TestCertificate;
*/

DROP PROCEDURE IF EXISTS [User].insertUser;
CREATE PROCEDURE [User].insertUser 
@UserType varchar,
@LastName varchar(45) ,
@FirstName varchar(45),
@PhoneNo varchar(45),
@Email varchar(45),
@Password varchar(45)
AS

BEGIN
	OPEN SYMMETRIC KEY TestSymmetricKey DECRYPTION BY CERTIFICATE TestCertificate;
	
	INSERT INTO [User].[User] (UserType,LastName, FirstName, PhoneNo,Email,Password)
	VALUES
	(@UserType, @LastName, @FirstName, @PhoneNo, @Email, EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary, @Password)));

	CLOSE SYMMETRIC KEY TestSymmetricKey;
END

-- test
/*
EXEC [User].insertUser 'M','MaxZhening','Jones','0123456789', 'manager@team1.com', 'TestManagerPS';
EXEC [User].insertUser 'C', 'Feng', 'Zheing', '6141234567', 'fengzhening@gmail.com', 'PassWordTEst1';
*/

/* DELETE TABLE OPERATOIN.
DELETE  FROM [User].Customer;
DELETE  FROM [User].Manager;
DELETE  FROM  [User].DeliveryPerson;
DELETE  FROM  [User].[User];
DELETE  FROM [User].Membership ;


DBCC CHECKIDENT ('[User].Customer', RESEED, 0);
DBCC CHECKIDENT ('[User].Manager ', RESEED, 0);
DBCC CHECKIDENT ('[User].DeliveryPerson', RESEED, 0);
DBCC CHECKIDENT ('[User].[User]', RESEED, 0);
DBCC CHECKIDENT ('[User].Membership', RESEED, 0);
*/