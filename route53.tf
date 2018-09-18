// rust-embedded.org
resource "aws_route53_zone" "rust_embedded_org" {
  name = "rust-embedded.org."
}

resource "aws_route53_record" "rust_embedded_org_a" {
  zone_id = "${aws_route53_zone.rust_embedded_org.zone_id}"
  name = "rust-embedded.org."
  type = "A"
  ttl = "300"

  // Github apex domain IP addresses
  // https://help.github.com/articles/setting-up-an-apex-domain/
  records = [
    "185.199.108.153",
    "185.199.109.153",
    "185.199.110.153",
    "185.199.111.153"
  ]
}

resource "aws_route53_record" "rust_embedded_org_www" {
  zone_id = "${aws_route53_zone.rust_embedded_org.zone_id}"
  name = "www.rust-embedded.org."
  type = "CNAME"
  ttl = "300"
  records = [ "rust-embedded.org" ]
}

resource "aws_route53_record" "rust_embedded_org_book_a" {
  zone_id = "${aws_route53_zone.rust_embedded_org.zone_id}"
  name = "book.rust-embedded.org."
  type = "A"
  ttl = "300"
  records = [
    "46.101.143.249"
  ]
}

resource "aws_route53_record" "rust_embedded_org_book" {
  zone_id = "${aws_route53_zone.rust_embedded_org.zone_id}"
  name = "book.rust-embedded.org."
  type = "CNAME"
  ttl = "300"
  records = [ "rust-embedded.org" ]
}

resource "aws_route53_record" "rust_embedded_org_embedonomicon" {
  zone_id = "${aws_route53_zone.rust_embedded_org.zone_id}"
  name = "embedonomicon.rust-embedded.org."
  type = "CNAME"
  ttl = "300"
  records = [ "rust-embedded.org" ]
}

// rust-embedded.com
resource "aws_route53_zone" "rust_embedded_com" {
  name = "rust-embedded.com."
}

resource "aws_s3_bucket" "rust_embedded_com_redirect" {
  bucket = "rust-embedded.com"
  acl = "public-read"
  website {
    redirect_all_requests_to = "rust-embedded.org"
  }
}

resource "aws_route53_record" "rust_embedded_com_a" {
  zone_id   = "${aws_route53_zone.rust_embedded_com.zone_id}"
  name      = "rust-embedded.com."
  type      = "A"
  alias {
    name    = "${aws_s3_bucket.rust_embedded_com_redirect.website_domain}"
    zone_id = "${aws_s3_bucket.rust_embedded_com_redirect.hosted_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_s3_bucket" "www_rust_embedded_com_redirect" {
  bucket = "www.rust-embedded.com"
  acl = "public-read"
  website {
    redirect_all_requests_to = "rust-embedded.org"
  }
}

resource "aws_route53_record" "rust_embedded_com_www" {
  zone_id   = "${aws_route53_zone.rust_embedded_com.zone_id}"
  name      = "www.rust-embedded.com."
  type      = "A"
  alias {
    name    = "${aws_s3_bucket.www_rust_embedded_com_redirect.website_domain}"
    zone_id = "${aws_s3_bucket.www_rust_embedded_com_redirect.hosted_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "rust_embedded_com_book" {
  zone_id = "${aws_route53_zone.rust_embedded_com.zone_id}"
  name = "book.rust-embedded.com."
  type = "CNAME"
  ttl = "300"
  records = [ "book.rust-embedded.org" ]
}

resource "aws_s3_bucket" "embedonomicon_rust_embedded_com_redirect" {
  bucket = "embedonomicon.rust-embedded.com"
  acl = "public-read"
  website {
    redirect_all_requests_to = "embedonomicon.rust-embedded.org"
  }
}

resource "aws_route53_record" "rust_embedded_com_embedonomicon" {
  zone_id   = "${aws_route53_zone.rust_embedded_com.zone_id}"
  name      = "embedonomicon.rust-embedded.com."
  type      = "A"
  alias {
    name    = "${aws_s3_bucket.embedonomicon_rust_embedded_com_redirect.website_domain}"
    zone_id = "${aws_s3_bucket.embedonomicon_rust_embedded_com_redirect.hosted_zone_id}"
    evaluate_target_health = false
  }
}

// areweembeddedyet.com

resource "aws_route53_zone" "areweembeddedyet_com" {
  name = "areweembeddedyet.com."
}

resource "aws_s3_bucket" "areweembeddedyet_com_redirect" {
  bucket = "areweembeddedyet.com"
  acl = "public-read"
  website {
    redirect_all_requests_to = "rust-embedded.org"
  }
}

resource "aws_route53_record" "areweembeddedyet_com_a" {
  zone_id = "${aws_route53_zone.areweembeddedyet_com.zone_id}"
  name = "areweembeddedyet.com."
  type = "A"
  alias {
    name    = "${aws_s3_bucket.areweembeddedyet_com_redirect.website_domain}"
    zone_id = "${aws_s3_bucket.areweembeddedyet_com_redirect.hosted_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_s3_bucket" "www_areweembeddedyet_com_redirect" {
  bucket = "www.areweembeddedyet.com"
  acl = "public-read"
  website {
    redirect_all_requests_to = "rust-embedded.org"
  }
}

resource "aws_route53_record" "areweembeddedyet_com_www" {
  zone_id = "${aws_route53_zone.areweembeddedyet_com.zone_id}"
  name = "www.areweembeddedyet.com."
  type = "A"
  alias {
    name    = "${aws_s3_bucket.www_areweembeddedyet_com_redirect.website_domain}"
    zone_id = "${aws_s3_bucket.www_areweembeddedyet_com_redirect.hosted_zone_id}"
    evaluate_target_health = false
  }
}
