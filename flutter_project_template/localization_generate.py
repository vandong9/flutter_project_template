import codecs
import json
import os

projectPath = os.path.dirname(__file__)

# There is case same class name when attibute in dictionary type have same name
#
#
localizedFolder = os.path.join(projectPath, 'lib/core/language/languages/')

outputPath = os.path.join(projectPath, 'lib/l.dart')


class DictionaryAttribute:
    def __init__(self, name, value):
        self.name = name
        self.value = value


def lowerOnlyFirstCharacter(string):
    firstCharacter = string[0:1].lower()
    return firstCharacter + string[1: len(string)]


def processAttributeName(attribute):
    replacedUnderscoreString = attribute.replace(" ", "_")
    replacedUnderscoreString = replacedUnderscoreString.title()
    removedSpaceString = replacedUnderscoreString.replace(" ", "")
    # adding Language to limit the conflict class name with other user defined class
    return removedSpaceString


def generateClassForDictoinaryAttribute(attributeName, attributeValue, level, isPrivateClass, isNeedExtendBaseClass):
    stringArray = []
    dictionaryAttributes = []
    underScore = ""
    if isPrivateClass:
        underScore = "_"
    extendBaseClass = ""
    if isNeedExtendBaseClass:
        extendBaseClass = " extends Base "
        stringArray.append("import 'base.dart';")
    stringArray.append(
        "class " + underScore + processAttributeName(attributeName) + extendBaseClass + " {")
    for attribute, value in attributeValue.iteritems():
        if isinstance(value, dict):
            dictionaryAttributes.append(DictionaryAttribute(attribute, value))
            attributeClassName = processAttributeName(attribute)
            stringArray.append(
                "_" + attributeClassName + " get " + lowerOnlyFirstCharacter(attributeClassName) + " => " + "_" + attributeClassName + "();")
            stringArray.append("\n\r")

        else:
            stringArray.append(
                "String get " + lowerOnlyFirstCharacter(processAttributeName(attribute)) + " => \"" + value + "\";")
            stringArray.append("\n\r")
    stringArray.append("}")
    for dictionary in dictionaryAttributes:
        nestString = generateClassForDictoinaryAttribute(
            dictionary.name, dictionary.value, level + 1, True, False)
        # stringArray.append(separator.join(nestString))
        stringArray.extend(nestString)
        stringArray.append("\n")

    return stringArray


def generateFileR(fileName, path):
    if ".json" not in fileName:
        return
    with open(path) as f:
        print("parse file: " + path)
        data = json.load(f)
        arrayStrings = []
        # add header
        arrayStrings.append(
            "//*** This is the automate generated file, DO NOT EDIT ***")
        arrayStrings.append("\n\r")

        # parse json to generate file dart
        separator = "\n"
        className = fileName.replace(".json", "")
        result = separator.join(
            generateClassForDictoinaryAttribute(className, data, 1, False, className != "base"))
        arrayStrings.extend(result)

        # generate file dart
        languageFileName = fileName.replace(".json", ".dart")
        fileR = codecs.open(os.path.join(
            localizedFolder, languageFileName), "w", "utf-8")
        fileR.writelines(arrayStrings)


# scan file json in folder
# there must be base.json file

# create file base.dart for base.json
# other file json will be parse to file dart which will be subclass to base.dart

for fileName in os.listdir(localizedFolder):
    newPath = os.path.join(localizedFolder, fileName)
    if os.path.isdir(newPath) == False:
        generateFileR(fileName, newPath)
