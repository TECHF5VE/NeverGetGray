import { Controller, Post, HttpCode, Body } from '@nestjs/common';
import { UserService } from './user.service';

@Controller('api/userinfo')
export class UserController {
  constructor(private readonly userService: UserService) {}
}
