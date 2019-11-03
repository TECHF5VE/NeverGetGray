import { Injectable, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { UserService } from './user.service';
import { JwtPayload } from './interfaces/jwt-payload.interface';
import { User } from '../../entity/user.entity';
import { AuthDto } from './dto/auth.dto';
import { compare } from 'bcrypt';
import { RegisterDto } from './dto/register.dto';
import { PRIVATE_KEY } from '../../constant/constantKey';

@Injectable()
export class AuthService {
  constructor(
    private readonly userService: UserService,
    private readonly jwtService: JwtService,
  ) {}

  /**
   * SignIn & Generate JWT
   * @param authDto AuthDto
   * @returns jwt string
   */
  async signIn({ username, password }: AuthDto): Promise<string> {
    const user = await this.userService.findByUsername(username);
    if (!user) {
      throw new UnauthorizedException();
    }
    const match = await compare(password, user.password);
    if (!match) {
      throw new UnauthorizedException();
    }
    const payload: JwtPayload = { id: user.id, username };
    return await this.jwtService.sign(payload);
  }

  /**
   * Register
   * @param username string
   * @param password string
   * @param privateKey string
   * @returns null
   */
  async register({
    username,
    password,
    privateKey,
  }: RegisterDto): Promise<null> {
    if (privateKey !== PRIVATE_KEY) {
      throw new UnauthorizedException();
    }
    const user = await this.userService.create(username, password);
    return null;
  }

  /**
   * Validate User
   * @param payload JwtPayload
   * @returns user | undefined
   */
  async validateUser(payload: JwtPayload): Promise<User | undefined> {
    return await this.userService.findByUsername(payload.username);
  }
}
