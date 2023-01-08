.data

	clegaturi: .space 400
	legaturi: .space 40000
	m1: .space 40000
	m2: .space 40000
	mres: .space 40000
	scan: .asciz "%ld\n"
	print: .asciz "%ld "
	pcer: .asciz "%ld \n"
	endl: .asciz "\n"
	cerinta: .space 4
	n: .space 4
	m: .space 4
	element: .space 4
	index: .long 0
	jndex: .long 0
	kndex: .long 0
	panterior: .long 0
	s: .long 0
	ns: .space 4
	nd: .space 4
	lun: .space 4
.text

.global main
matrix_mult:
	pushl %ebp
	mov %esp,%ebp
	pushl %ebx
	pushl %edi
	subl $24,%esp	
	mov 8(%ebp),%ebx
	mov 12(%ebp),%edi
	mov 16(%ebp),%edx 
	mov 20(%ebp),%ecx
	movl $0,-20(%ebp)
	
	for_iii:
		cmp -20(%ebp),%ecx
		je pro_exit
		movl $0,-24(%ebp)
		for_jjj:
			cmp -24(%ebp),%ecx
			je ipp
			movl $0,-28(%ebp)
			for_kkk:
				cmp -28(%ebp),%ecx
				je jpp
				
				movl -20(%ebp),%eax
				movl $0,%edx
				mull %ecx
				addl -28(%ebp),%eax
				movl %eax,-32(%ebp)
				
				movl -28(%ebp),%eax
				movl $0,%edx
				mull %ecx
				addl -24(%ebp),%eax
				movl %eax,-36(%ebp)
				
				movl -20(%ebp),%eax
				movl $0,%edx
				mull %ecx
				addl -24(%ebp),%eax
				movl %eax,-44(%ebp)
				
				movl -32(%ebp),%edx
				movl (%ebx,%edx,4),%eax
				movl -36(%ebp),%edx
				movl (%edi,%edx,4),%ecx
				movl $0,%edx
				mull %ecx
				
				mov 16(%ebp),%edx 
				
				movl -44(%ebp),%ecx
				addl %eax,(%edx,%ecx,4)
				
				mov 20(%ebp),%ecx
				
				
				incl -28(%ebp)
				jmp for_kkk
				
	
	jpp:
		incl -24(%ebp)
		jmp for_jjj
	
	ipp:
		incl -20(%ebp)
		jmp for_iii
	
	pro_exit:
	addl $24,%esp
	popl %edi
	popl %ebx
	popl %ebp
	ret
main:
	pushl $cerinta
	pushl $scan
	call scanf
	addl $8,%esp
					
	pushl $n
	pushl $scan
	call scanf
	addl $8,%esp
		
	xor %ecx,%ecx
	lea clegaturi, %edi
	xor %edx,%edx
	
	
		for_clegaturi:
			cmp %ecx,n
			je fout
			push %ecx
			push %edx
			pushl $element
			pushl $scan
			call scanf
			addl $8,%esp
			pop %edx
			pop %ecx
			movl element, %ebx	
			movl %ebx,(%edi,%ecx,4)
			addl element,%edx
			incl %ecx
			jmp for_clegaturi	
	
fout:
	movl %edx, m
	xor %ecx,%ecx
	lea legaturi,%edi
	
	for_legaturi:
		cmp %ecx,m
		je fout2
		pushl %ecx
		
		pushl $element
		pushl $scan
		call scanf
		addl $8,%esp
		pop %ecx
		
		movl element, %ebx	
		movl %ebx,(%edi,%ecx,4)
		
		incl %ecx
		jmp for_legaturi
		
fout2:
	for_i:
		movl index,%ebx
		cmp %ebx,n
		je verificare2
		cmp $0,%ebx
		jne cresc
		
		inapoi:
		lea clegaturi,%edi
		movl index,%ecx
		movl panterior,%eax
		addl (%edi,%ecx,4),%eax
		movl %eax,s
		
		for_j:
			movl jndex,%ebx
			cmp %ebx,s
			je cre_i
			lea legaturi,%edi
			movl index,%eax
			movl $0,%edx
			mull n
			addl (%edi,%ebx,4),%eax
			lea m1,%edi
			movl $1,(%edi,%eax,4)
			
			incl jndex
			jmp for_j
		

cresc:
	lea clegaturi,%edi
	movl index, %ecx
	sub $1,%ecx
	movl panterior,%eax
	addl (%edi,%ecx,4),%eax
	movl %eax, panterior
	jmp inapoi
	
cre_i:
	incl index
	jmp for_i
	
verificare2:
	movl cerinta,%ebx
	cmp $2,%ebx
	je cerinta2
		
afis:
	movl $0,index
	
	for_index:
		movl index,%ecx
		cmp %ecx,n
		je exit
		
	movl $0,jndex
	for_jndex:
		movl jndex,%ecx
		cmp %ecx,n
		je cont
		
		movl index,%eax
		movl $0,%edx
		mull n
		addl jndex,%eax
		
		lea m1, %edi
		movl (%edi,%eax,4),%ebx
		
		pushl %ebx
		pushl $print
		call printf
		addl $8,%esp
		
		pushl $0
		call fflush
		pop %ebx
		
		incl jndex
		jmp for_jndex
	cont:
		movl $4,%eax
		movl $1,%ebx
		movl $endl,%ecx
		movl $2,%edx
		int $0x80
		
		incl index
		jmp for_index

cerinta2:
	
	pushl $lun
	pushl $scan
	call scanf
	addl $8,%esp
	
	pushl $ns
	pushl $scan
	call scanf
	addl $8,%esp
	
	pushl $nd
	pushl $scan
	call scanf
	addl $8,%esp
	
	movl lun,%eax
	sub $1,%eax
	movl %eax,lun
	push n
	push $mres
	push $m1
	push $m1
	call matrix_mult
	addl $16,%esp
	
	movl $1,index
	for_ii:
		movl index,%ebx
		cmp %ebx,lun
		je afis2
		movl $0,jndex
		for_jj:
			movl jndex,%ebx
			cmp %ebx,n
			je matmul
			movl $0,kndex
			for_kk:
				movl kndex,%ebx
				cmp %ebx,n
				je cre_j
				
				lea mres,%edi
				movl jndex,%eax
				movl $0,%edx
				mull n
				addl kndex,%eax
				movl (%edi,%eax,4),%ecx
				
				lea m2,%edi
				movl %ecx,(%edi,%eax,4)
				
				incl kndex
				jmp for_kk
			cre_j:
			incl jndex
			jmp for_jj

	matmul:
	push n
	push $mres
	push $m2
	push $m1
	call matrix_mult
	addl $16,%esp	
		incl index
		jmp for_ii
	
	
	afis2:
		
		lea mres,%edi
		movl ns,%eax
		movl $0,%edx
		mull n
		addl nd,%eax
		movl (%edi,%eax,4),%ebx
		
		push %ebx
		push $pcer
		call printf
		addl $8,%esp
		

	exit:
		mov $1,%eax
		xor %ebx,%ebx
		int $0x80
		
