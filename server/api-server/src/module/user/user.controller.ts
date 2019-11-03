import { Controller, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { UserService } from '../auth/user.service';

@Controller('userinfo')
@UseGuards(AuthGuard())
export class UserController {
  constructor(private readonly userService: UserService) {}
}
