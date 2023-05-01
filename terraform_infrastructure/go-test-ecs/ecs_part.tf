resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.cluster_name
}

resource "aws_ecs_task_definition" "task_definition" {
  family             = "go-test-td"
  execution_role_arn = "arn:aws:iam::289002034845:role/ecsTaskExecutionRole"
  memory             = 128
  cpu                = 128
  container_definitions = jsonencode([
    {
      name      = "go-test"
      image     = "${aws_ecr_repository.go-test-repo.repository_url}:latest"
      cpu       = 128
      memory    = 128
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 80
        }
      ]
    }
  ])
  tags = merge(
    {
      Name = "go-test"
    }
  )
}
resource "aws_ecs_service" "go-test-service" {
  name            = "go-test-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = 1
}
