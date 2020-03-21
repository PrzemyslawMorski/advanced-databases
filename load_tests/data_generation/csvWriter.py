import csv
import logging
from generators.actorGenerator import Actor

import sys
sys.path.append("..")

class CSVWriter:

    def mapToFiles(self):
        return {
            "customer": "3055",
            "actor": "3057",
            "category": "3059",
            "film": "3061",
            "film_actor": "3062",
            "film_category": "3063",
            "address": "3065",
            "city": "3067",
            "country": "3069",
            "inventory": "3071",
            "language": "3073",
            "payment": "3075",
            "rental": "3077",
            "staff": "3079",
            "store": "3081"
        }

    def __init__(self):
        self.entityFilesMap = self.mapToFiles()
        self.logger = logging.getLogger('## app-log ##')

    def writeActors(self):
        actors = Actor.generate(number=1000)
        self.writeToFile("actor", actors)


    def writeToFile(self, entity, data):
        fileName = "./output/" + self.entityFilesMap.get(entity) + ".dat"
        self.deleteLastLines(fileName)
        with open(fileName, 'a', newline='') as f:
            writer = csv.writer(f, delimiter="\t")
            self.logger.info("SAVING RESULTS TO FILE")
            f.write("\r\n")
            for line in data:
                writer.writerow(vars(line).values())
            f.write("\.\r\n\r\n\r\n")
        #self.deleteLastLine(fileName)

    def getClassProperties(self, obj):
        attrs = vars(obj).values()
        # {'kids': 0, 'name': 'Dog', 'color': 'Spotted', 'age': 10, 'legs': 2, 'smell': 'Alot'}
        # now dump this in some way or another
        print(', '.join("%s: %s" % item for item in attrs.items()))

    def deleteLastLines(self, fileName):
        fd = open(fileName, "r")
        d = fd.read()
        fd.close()
        m = d.split("\n")
        s = "\n".join(m[:-4])
        fd = open(fileName, "w+")
        for i in range(len(s)):
            fd.write(s[i])
        fd.close()

