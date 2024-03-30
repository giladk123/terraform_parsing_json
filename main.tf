locals {
  # Decoding the JSON file "zscalar.json"
  foo = jsondecode(file("zscalar.json"))

  # Flattening the list of IP ranges from the decoded JSON file
  ip_ranges = flatten([
    # Iterating over each continent and its cities in the decoded JSON
    for continent, cities in local.foo["zscalerthree.net"] : 
      # Iterating over each city and its details
      [for city, details in cities : 
        # Iterating over each detail and extracting the IP range if it exists
        [for detail in details : 
          [detail.range] if contains(keys(detail), "range")]
      ]
  ])

  # Flattening the list of cities from the decoded JSON file
  cities_list = flatten([
    # Iterating over each continent and its cities in the decoded JSON
    for continent, cities in local.foo["zscalerthree.net"] : 
      # Extracting the city names
      [for city in keys(cities) : 
        city
      ]
  ])
  
  # Extracting the list of continents from the decoded JSON file
  continents_list = keys(local.foo["zscalerthree.net"])
}

# Outputting the list of IP ranges
output "ip_ranges" {
  value = local.ip_ranges
}

# Outputting the list of cities
output "cities_list" {
  value = local.cities_list
}

# Outputting the list of continents
output "continents_list" {
  value = local.continents_list
}