def generator():
    links_number = 25
    link_beggining = "https://www.trustpilot.com/review/smarter-phone.co?languages=en&page="

    file = open("links_list.txt","w")
    for i in range(0, links_number):
        link = link_beggining + str(i+1)
        file.write(link)
        file.write("\n")
    file.close()