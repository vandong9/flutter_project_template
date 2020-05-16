import codecs
import json
import os

projectPath = os.path.dirname(__file__)

###
# There must have file base.json that contain all the keyword
# The language json file should follow the code ex: en, fr
# ex:
# base.json
# {
#   "Hello world": "Hello world",
#   "Hello Other": {
#       "Hello in English": "Hello in English",
#       "Hello in VietNam": "Hello in VietNam"
#   }
# }
# vn.json
# {
#   "Hello world": "Chào thế giới",
#   "Hello Other": {
#       "Hello in English": "Chào bằng Tiếng Anh",
#       "Hello in VietNam": "Chào bằng Tiếng Việt"
#   }
# }
#
# The Out put:
#
# base.dart
# class Base {
#   String get helloWorld => "Chào thế giới";
#   BaseHelloOther hello_Other => BaseHello_Other();
# }

# class BaseHello_Other {
#     String get hello_In_English => "Hello in English";
#     String get hello_In_Vietnam => "Hello in VietNam";
# }
#
# vn.dart
# class Vn extends Base {
#   String get helloWorld => "Hello world";
#   BaseHelloOther hello_Other => VnHello_Other();
# }

# class VnHello_Other extends BaseHello_Other {
#     String get hello_In_English => "Chào bằng Tiếng Anh";
#     String get hello_In_Vietnam => "Chào bằng Tiếng Việt";
# }
#
###

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
    replacedUnderscoreString = attribute.title()
    replacedUnderscoreString = replacedUnderscoreString.replace(" ", "_")
    # adding Language to limit the conflict class name with other user defined class
    return replacedUnderscoreString


def generateClassForDictoinaryAttribute(languageFileName, isBase, isRootNode, attributeName, attributeValue, level, isPrivateClass):
    stringArray = []
    dictionaryAttributes = []
    extendBaseClass = ""
    prefixClass = ""
    if isBase:
        if isRootNode == False:
            prefixClass = "Base"
    else:
        if isRootNode:
            stringArray.append("import 'base.dart';")
            extendBaseClass = " extends Base"
            prefixClass = languageFileName.title()

        else:
            prefixClass = languageFileName.title()
            extendBaseClass = " extends Base" + \
                processAttributeName(attributeName) + " "


# if not base.json
# need import base.dart
#
# if isRootNode node of json file
#    need extend base class if not the base.json file
# else
#    if attribute is dictionary
#       create new class
#          if base.json file
#               class name have prefix Base
#          else will have prefix by json file name
#       create property with type is new class from base.json file  ex:  BaseChild child = EnChild()
#    else  create new string property
#
    defineClassPrefix = ""
    if isRootNode == False:
        defineClassPrefix = prefixClass
    stringArray.append(

        "class " + defineClassPrefix + processAttributeName(attributeName) + extendBaseClass + " {")
    for attribute, value in attributeValue.iteritems():
        if isinstance(value, dict):
            dictionaryAttributes.append(DictionaryAttribute(attribute, value))
            attributeClassName = processAttributeName(attribute)
            if isBase:
                prefixClass = "Base"
            stringArray.append(
                "Base" + attributeClassName + " get " + lowerOnlyFirstCharacter(attributeClassName) + " => " + prefixClass + attributeClassName + "();")
            stringArray.append("\n\r")

        else:
            stringArray.append(
                "String get " + lowerOnlyFirstCharacter(processAttributeName(attribute)) + " => \"" + value + "\";")
            stringArray.append("\n\r")
    stringArray.append("}")
    for dictionary in dictionaryAttributes:
        nestString = generateClassForDictoinaryAttribute(
            languageFileName, isBase, False, dictionary.name, dictionary.value, level + 1, True)
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
            generateClassForDictoinaryAttribute(className, className == "base", True, className, data, 1, False))
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
