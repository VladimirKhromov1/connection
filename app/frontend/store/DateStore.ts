import type { Account } from './AccountStore'

export type Date = {
    creator: Account,
    recipient: Account,
    responsed: boolean,
    timeOfDate: string
}