import { Controller, Post, HttpCode, Body } from '@nestjs/common';
import { LoginDto } from './dto/login.dto';
import { UserService } from 'src/user/user.service';
import { AuthService } from './auth.service';

@Controller('api/session')
export class AuthController {
  constructor(
    private readonly userService: UserService,
    private readonly authService: AuthService,
  ) {}

  @Post()
  @HttpCode(200)
  async login(@Body() dto: LoginDto) {
    const user = await this.userService.findOneByUsername(dto.username);
    if (user && user.password === dto.password) {
      return this.authService.createToken(user.username);
    }
    return 'error';
  }
}
