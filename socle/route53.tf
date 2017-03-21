data "aws_route53_zone" "myzone" {
  name = "vsct-hackathon.com"
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
