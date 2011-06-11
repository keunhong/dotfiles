import urllib.request, urllib.parse, urllib.error
import xml.etree.ElementTree as ETree

# XML related functions
def get_xml_raw(url):
    try:
        data = urllib.request.urlopen(url)
    except URLError as e:
        print(e)
    return data
    
def get_xml_tree(url):
    data = get_xml_raw(url)
    if(data):
        try:
            tree = ETree.parse(data)
        except SyntaxError:
            print("Syntax Error")
        else:
            return tree

def main():
    location = "Gyeonggi-do"
    data_tree = get_xml_tree("http://www.google.com/ig/api?weather=Gyeonggi-do&hl=en-gb")

    condition = data_tree.find("weather/current_conditions/condition").get("data")
    current_temp_c = data_tree.find("weather/current_conditions/temp_c").get("data")
    forecast_low_c = data_tree.find("weather/forecast_conditions/low").get("data")
    forecast_high_c = data_tree.find("weather/forecast_conditions/high").get("data")

    print("^fg(#ebac54)N:^fg() {} C, ^fg(#ebac54)L:^fg() {}, ^fg(#ebac54)H:^fg() {}, {}".format(current_temp_c, forecast_low_c, forecast_high_c, condition))
    
if __name__ == '__main__':
    main()
