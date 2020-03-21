
string = "store (store_id, manager_staff_id, address_id, last_update)"

entityName = string.split(" ")[0].title()
properties = string.split("(")[1]
properties = "    " + properties
properties = properties[:-1]
properties = properties.replace(", ", " = None \n    ")
properties = properties + " = None \n"
outputString = """from dataclasses import dataclass


@dataclass
class {}:
{}
""".format(entityName, properties)

with open("./generators/{}Generator.py".format(entityName.lower()),
          'w', newline='') as f:
    f.write(outputString)
print(outputString)
