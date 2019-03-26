import { Base } from 'src/base.entity';
import { Entity, Column } from 'typeorm';

@Entity('Ngg_User')
export class User extends Base {
  @Column({
    unique: true,
    nullable: false,
  })
  username: string;

  @Column({
    nullable: false,
  })
  password: string;

  @Column({
    type: 'bigint',
    nullable: false,
    default: 0,
  })
  signNum: number;
}
