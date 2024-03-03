import requests
from array import *

ENDPOINT = "https://api.strawpoll.com/v3"
API_KEY = "xxxx"

# Use "NPgxkzPqrn2" for an example without participants

poll_id = "NPgxkzPqrn2"

response = requests.get(ENDPOINT + '/polls/' + poll_id + '/results', headers = { 'X-API-KEY': API_KEY })

if response:
    poll_results = response.json()
    votes = []
    values = []
    
    for option in poll_results["poll_options"]:
        votes.append(option["vote_count"])
        values.append(str(option["value"]))
    sorted_arrays = sorted(zip(votes, values), reverse=True)
    sorted_2d_array = [[votes, values] for votes, values in sorted_arrays]
    
    parser = []
    counter = 1
    for row in sorted_2d_array:
        for elem in row:
            parser.append(elem)
        counter = counter + 1
        if counter == 4:
            break

    counter = 1
    for elem in parser:
        file_path = "/tmp/" + str(counter) + ".txt"
        with open(file_path, "w") as file:
            file.write(str(elem))
        counter = counter + 1
else:
    error = response.json()
    print(error)