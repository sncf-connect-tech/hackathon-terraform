data "aws_route53_zone" "myzone" {
  name = "vsct-hackathon.com"
}

resource "aws_route53_record" "shinken" {
  zone_id = "${data.aws_route53_zone.myzone.zone_id}"
  name = "shinken.${data.aws_route53_zone.myzone.name}"
  type = "A"
  ttl = "300"
  records = ["${aws_instance.shinken.public_ip}"]
}

resource "aws_route53_record" "bastion" {
  zone_id = "${data.aws_route53_zone.myzone.zone_id}"
  name = "bastion.${data.aws_route53_zone.myzone.name}"
  type = "A"
  ttl = "300"
  records = ["${aws_instance.bastion.public_ip}"]
}

resource "aws_route53_record" "bastion2" {
  zone_id = "${data.aws_route53_zone.myzone.zone_id}"
  name = "bastion2.${data.aws_route53_zone.myzone.name}"
  type = "A"
  ttl = "300"
  records = ["${aws_instance.bastion2.public_ip}"]
}

resource "aws_route53_record" "lb-bastion1" {
  zone_id = "${data.aws_route53_zone.myzone.zone_id}"
  name = "lb-bastion.${data.aws_route53_zone.myzone.name}"
  type = "CNAME"
  ttl = "1"
  
  weighted_routing_policy {
    weight = 66
  }

  set_identifier = "bastion"
  records = ["bastion.${data.aws_route53_zone.myzone.name}"]
}
  
resource "aws_route53_record" "lb-bastion2" {
  zone_id = "${data.aws_route53_zone.myzone.zone_id}"
  name = "lb-bastion.${data.aws_route53_zone.myzone.name}"
  type = "CNAME"
  ttl = "1"
  
  weighted_routing_policy {
    weight = 33
  }

  set_identifier = "bastion2"
  records = ["bastion2.${data.aws_route53_zone.myzone.name}"]
}
  
