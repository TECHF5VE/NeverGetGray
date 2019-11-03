import { Controller, Post, Body, HttpCode, Put } from '@nestjs/common';
import { AuthDto, AuthResp } from './dto/auth.dto';
import { AuthService } from './auth.service';
import { success, Resp } from '../../util/resp';
import { RegisterDto } from './dto/register.dto';

@Controller('session')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post()
  @HttpCode(200)
  async sign(@Body() authDto: AuthDto): Promise<Resp<AuthResp>> {
    const token = await this.authService.signIn(authDto);
    return success<AuthResp>({ auth_key: token });
  }

  @Put()
  @HttpCode(200)
  async register(@Body() registerDto: RegisterDto): Promise<Resp<null>> {
    const user = await this.authService.register(registerDto);
    return success<any>(user);
  }
}
