ALTER TABLE film ADD COLUMN actors_xml xml DEFAULT xmlroot(xmlelement(name actors), version '1.0');
ALTER TABLE actor ADD COLUMN films_xml xml DEFAULT xmlroot(xmlelement(name films), version '1.0');
