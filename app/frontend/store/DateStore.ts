import type { Account } from './AccountStore'

export type Date = {
    id: number,
    creator: Account,
    recipient: Account,
    responsed: string,
    timeOfDate: string
}