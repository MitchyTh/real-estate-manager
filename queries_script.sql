USE RealEstateDB;


SELECT H.address
FROM House H
INNER JOIN Listings L ON H.address = L.address;

SELECT H.address, L.mlsNumber
FROM House H
INNER JOIN Listings L ON H.address = L.address;

SELECT H.address
FROM House H
INNER JOIN Listings L ON H.address = L.address
WHERE H.bedrooms = 3 AND H.bathrooms = 2;

SELECT H.address, P.price
FROM House H
JOIN Listings L ON H.address = L.address
JOIN Property P ON H.address = P.address
WHERE H.bedrooms = 3
  AND H.bathrooms = 2
  AND P.price BETWEEN 100000 AND 250000
ORDER BY P.price DESC;

SELECT BP.address, P.price
FROM BusinessProperty BP
JOIN Listings L ON BP.address = L.address
JOIN Property P ON BP.address = P.address
WHERE BP.type = 'office space'
ORDER BY P.price DESC;

SELECT A.agentId, A.name, A.phone, F.name AS firmName, A.dateStarted
FROM Agent A
JOIN Firm F ON A.firmId = F.id;

SELECT P.* FROM Property P
JOIN Listings L ON P.address = L.address
WHERE L.agentId = 1;

SELECT A.name AS AgentName, B.name AS BuyerName
FROM Agent A
JOIN Works_With W ON A.agentId = W.agentId
JOIN Buyer B ON W.buyerId = B.id
ORDER BY A.name ASC;

SELECT agentId, COUNT(buyerId) AS totalBuyers
FROM Works_With
GROUP BY agentId;

SELECT H.address, P.price
FROM House H
JOIN Property P ON H.address = P.address
JOIN Listings L ON H.address = L.address -- Ensuring it is currently listed
JOIN Buyer B ON B.id = 201
WHERE H.bedrooms = B.bedrooms
  AND H.bathrooms = B.bathrooms
  AND P.price BETWEEN B.minimumPreferredPrice AND B.maximumPreferredPrice
ORDER BY P.price DESC;
