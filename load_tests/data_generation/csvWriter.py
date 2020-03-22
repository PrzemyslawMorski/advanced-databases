import csv
import logging
import sys

from generators.actorGenerator import Actor
from generators.addressGenerator import Address
from generators.cityGenerator import City
from generators.customerGenerator import Customer
from generators.filmGenerator import Film
from generators.film_actorGenerator import FilmActor
from generators.film_categoryGenerator import FilmCategory
from generators.inventoryGenerator import Inventory
from generators.paymentGenerator import Payment
from generators.rentalGenerator import Rental
from generators.staffGenerator import Staff
from generators.storeGenerator import Store

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

    actors = None

    def __init__(self):
        self.entityFilesMap = self.mapToFiles()
        self.logger = logging.getLogger('## app-log ##')

    def writeCities(self, number):
        self.cities = City.generate(number)
        self.writeToFile("city", self.cities)

    def writeAddresses(self, number):
        self.addresses = Address.generate(cities=self.cities, number=number)
        self.writeToFile("address", self.addresses)

    def writeActors(self, number):
        self.actors = Actor.generate(number=number)
        self.writeToFile("actor", self.actors)

    def writeStaff(self, number):
        self.staff = Staff.generate(addresses=self.addresses, stores=self.stores, number=number)
        self.writeToFile("staff", self.staff)

    def writeCustomers(self, number):
        self.customers = Customer.generate(self.addresses, self.stores, number)
        self.writeToFile("customer", self.customers)

    def writeStores(self, number):
        managers = Staff.generate(addresses=self.addresses, stores=None, number=number)
        self.stores = Store.generate(addresses=self.addresses, managers=managers)
        self.writeToFile("staff", managers)
        self.writeToFile("store", self.stores)

    def writeFilms(self, number):
        self.films = Film.generate(number)
        self.writeToFile("film", self.films)

        self.film_categories = FilmCategory.generate(self.films)
        self.writeToFile("film_category", self.film_categories)

        self.film_actors = FilmActor.generate(self.films, self.actors)
        self.writeToFile("film_actor", self.film_actors)

    def writeInventories(self, number):
        self.inventories = Inventory.generate(self.films, self.stores, number)
        self.writeToFile("inventory", self.inventories)

    def writeRentals(self, number):
        self.rentals = Rental.generate(inventories=self.inventories, staffs=self.staff, customers=self.customers, number=number)
        self.writeToFile("rental", self.rentals)

    def writePayments(self, number):
        self.payments = Payment.generate(staffs=self.staff, rentals=self.rentals, number=number)
        self.writeToFile("payment", self.payments)

    def writeToFile(self, entity, data):
        fileName = "./output/" + self.entityFilesMap.get(entity) + ".dat"
        self.deleteLastLines(fileName)
        with open(fileName, 'a', newline='') as f:
            writer = csv.writer(f, delimiter="\t")
            self.logger.info("SAVING RESULTS TO FILE: {}".format(entity))
            f.write("\r\n")
            for line in data:
                writer.writerow(vars(line).values())
            f.write("\.\r\n\r\n\r\n")
        # self.deleteLastLine(fileName)

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
