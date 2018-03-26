resource "aws_alb" "web" {
  name            = "web-${var.environment}"
  internal        = false
  security_groups = ["${aws_security_group.allow-all-http-incoming.id}"]
  subnets         = ["${local.subnets_ids}"]

  tags {
    environment = "${var.environment}"
  }
}

resource "aws_alb_target_group" "web" {
  name     = "web-target-group-${var.environment}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc-id}"
}

resource "aws_alb_listener" "web" {
  load_balancer_arn = "${aws_alb.web.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.web.arn}"
    type             = "forward"
  }
}

resource "aws_alb_target_group_attachment" "web" {
  target_group_arn = "${aws_alb_target_group.web.arn}"
  target_id        = "${aws_instance.web.*.id}"
  port             = 3000
}
