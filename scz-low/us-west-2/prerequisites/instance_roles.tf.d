resource "aws_iam_role" "instance_role" {
  name               = "anfw-session-manager-instance-profile-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Principal": {"Service": "ec2.amazonaws.com"},
    "Action": "sts:AssumeRole"
  }
}
EOF

  tags          = merge(var.tags,
    {
      Name = "afwn_iam-instance-role"
    },
  )
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "anfw-session-manager-instance-profile"
  role = aws_iam_role.instance_role.name

  tags          = merge(var.tags,
    {
      Name = "afwn_iam-instance-prfl"
    },
  )
}

resource "aws_iam_role_policy_attachment" "instance_role_policy_attachment" {
  role       = aws_iam_role.instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}