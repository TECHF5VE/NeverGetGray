import { ExtractJwt, Strategy } from 'passport-jwt';
import { AuthService } from './auth.service';
import { PassportStrategy } from '@nestjs/passport';
import { Injectable, UnauthorizedException } from '@nestjs/common';
import { secretKey } from 'src/constant/constantKey';
import { JwtPayload } from './interfaces/jwt-payload.interface';

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
  constructor(private readonly authService: AuthService) {
    super({
      jwtFromRequest: ExtractJwt.fromExtractors([
        ExtractJwt.fromUrlQueryParameter('auth_key'),
        ExtractJwt.fromBodyField('auth_key'),
      ]),
      secretOrKey: secretKey,
    });
  }

  async validate(payload: JwtPayload, done: (...args: any) => any) {
    const user = await this.authService.validateUser(payload.username);
    if (!user) {
      return done(new UnauthorizedException(), false);
    }
    done(null, user);
  }
}
