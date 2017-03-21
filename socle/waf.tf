resource "aws_waf_ipset" "IP_req_web" {
  name = "tfIPSet"

  ip_set_descriptors {
    type  = "IPV4"
	#IP des requetes web
    value = "90.34.217.106/32"
  }
}

resource "aws_waf_rule" "wafrule" {
  depends_on  = ["aws_waf_ipset.IP_req_web"]
  name        = "tfWAFRule"
  metric_name = "tfWAFRule"

  predicates {
    data_id = "${aws_waf_ipset.IP_req_web.id}"
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_web_acl" "waf_acl" {
  depends_on  = ["aws_waf_ipset.IP_req_web", "aws_waf_rule.wafrule"]
  name        = "tfWebACL"
  metric_name = "tfWebACL"

  default_action {
    type = "ALLOW"
  }

  rules {
    action {
      type = "BLOCK"
    }

    priority = 1
    rule_id  = "${aws_waf_rule.wafrule.id}"
  }
}
