
createdb afinititest

--Create Table--
CREATE TABLE snmpSignals (
    signalValue int,
    signalTime timestamp DEFAULT CURRENT_TIMESTAMP);

--Insert in Table 'snmpSignals'--
INSERT INTO snmpSignals (signalValue) VALUES (23)
INSERT INTO snmpSignals (signalValue) VALUES (25)
INSERT INTO snmpSignals (signalValue) VALUES (27)
INSERT INTO snmpSignals (signalValue) VALUES (29)
INSERT INTO snmpSignals (signalValue) VALUES (21)
INSERT INTO snmpSignals (signalValue) VALUES (20)
INSERT INTO snmpSignals (signalValue) VALUES (30)
INSERT INTO snmpSignals (signalValue) VALUES (32)
INSERT INTO snmpSignals (signalValue) VALUES (25)
INSERT INTO snmpSignals (signalValue) VALUES (23)


--Find latest signal value--
SELECT signalValue 
FROM snmpSignals
Where signalTime= (Select MAX(signalTime) from snmpSignals);

