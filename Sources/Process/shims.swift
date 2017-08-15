/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

/* If WIFEXITED(STATUS), the low-order 8 bits of the status.  */
func WEXITSTATUS(_ status: Int32) -> Int32 {
    return (status >> 8) & 0xff
}

/* If WIFSIGNALED(STATUS), the terminating signal.  */
func WTERMSIG(_ status: Int32) -> Int32 {
    return status & 0x7f
}

/* If WIFSIGNALED(STATUS), the terminating signal.  */
func WSTOPSIG(_ status: Int32) -> Int32 {
    return WEXITSTATUS(status)
}

/* Nonzero if STATUS indicates normal termination.  */
func WIFEXITED(_ status: Int32) -> Bool {
    return WTERMSIG(status) == 0
}

/* Nonzero if STATUS indicates termination by a signal.  */
func WIFSIGNALED(_ status: Int32) -> Bool {
    return ((status & 0x7f) + 1 >> 1) > 0
}

/* Nonzero if STATUS indicates the child is stopped.  */
func WIFSTOPPED(_ status: Int32) -> Bool {
    return (status & 0xff) == 0x7f
}

/* Nonzero if STATUS indicates the child continued after a stop.  */
func WIFCONTINUED(_ status: Int32) -> Bool {
    return status == 0xffff
}
