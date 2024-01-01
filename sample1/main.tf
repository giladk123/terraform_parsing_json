locals {
  foo = jsondecode(file("zscalar.json"))

  root_node = local.foo["zscalerthree.net"]

  expected = flatten([
    for continent, cities in local.root_node : [
      for city, details in cities : {
        display_name  = "${replace(continent, "continent : ", "")}/${replace(city, "city : ", "")}"
        address_space = [for detail in details : detail.range if detail.range != ""]
      }
    ]
  ])
}
# desired output structure:
# display_name = APAC/Auckland
# ip_range = 124.248.141.0/24

output "good_stuff" {
  value = local.expected
}