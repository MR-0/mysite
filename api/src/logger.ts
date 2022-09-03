import debug from 'debug'

interface loggersInterface {
  [key:string]: debug.Debugger
}
const loggers: loggersInterface = {}

export default (
  message:any,
  scope:string = 'DEFAULT'
) => {
  if (!loggers[scope]) loggers[scope] = debug(scope)
  loggers[scope](`--> ${message}`)
}