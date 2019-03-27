//
//  Contato.m
//  FormularioContatoViewController
//
//  Created by ios8106 on 3/19/19.
//  Copyright © 2019 caelum. All rights reserved.
//

#import "Contato.h"

@implementation Contato

-(NSString *) description{
    return [NSString stringWithFormat: @"Nome: %@, Telefone: %@,Endereço: %@,Site: %@",
            self.nome, self.telefone, self.endereco, self.siteText];
}

-(CLLocationCoordinate2D)coordinate {
        return CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
}

- (NSString *)title{
    return self.nome;
}

- (NSString *)subtitle{
    return self.siteText;
}



@end


 
