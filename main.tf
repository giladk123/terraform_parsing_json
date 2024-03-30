locals {
  foo = jsondecode(file("zscalar.json"))

  ip_ranges = flatten([
    for continent, cities in local.foo["zscalerthree.net"] : 
      [for city, details in cities : 
        [for detail in details : 
          [detail.range] if contains(keys(detail), "range")]
      ]
  ])

  cities_list = flatten([
    for continent, cities in local.foo["zscalerthree.net"] : 
      [for city in keys(cities) : 
        city
      ]
  ])
  
  continents_list = keys(local.foo["zscalerthree.net"])

}
output "ip_ranges" {
  value = local.ip_ranges
}

output "cities_list" {
  value = local.cities_list
}

output "continents_list" {
  value = local.continents_list
}
