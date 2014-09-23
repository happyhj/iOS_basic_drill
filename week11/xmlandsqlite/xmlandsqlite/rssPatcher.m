//
//  rssPatcher.m
//  xmlandsqlite
//
//  Created by KIM HEE JAE on 9/18/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "rssPatcher.h"

@implementation rssPatcher
{
    NSMutableDictionary *item_buffer;
    NSString *current_key;
    NSMutableString *current_value;
}

-(id)init {
    self = [super init];
    if (self)
    {
        NSURL *url = [[NSURL alloc] initWithString:@"http://images.apple.com/main/rss/hotnews/hotnews.rss"];
        NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
        
        [xmlParser setDelegate:self];
        [xmlParser parse];
    }
    return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict {
    
    if([elementName isEqualToString:@"title"]) {
        current_key = elementName;
    }
    else if([elementName isEqualToString:@"link"]) {
        current_key = elementName;
    }
    else if([elementName isEqualToString:@"description"]) {
        current_key = elementName;
    }
    else if([elementName isEqualToString:@"pubDate"]) {
        current_key = elementName;
    }
    
    current_value = [@"" mutableCopy];

    //NSLog(@"Processing Element: %@", elementName);
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    NSMutableString * currentElementValue;
    
    if(!currentElementValue)
        currentElementValue = [[NSMutableString alloc] initWithString:string];
    else
        [currentElementValue appendString:string];
    
    NSLog(@"Processing Value: %@", currentElementValue);
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if([elementName isEqualToString:@"Books"])
        return;
    
    //There is nothing to do if we encounter the Books element here.
    //If we encounter the Book element howevere, we want to add the book object to the array
    // and release the object.
    if([elementName isEqualToString:@"Book"]) {
        [appDelegate.books addObject:aBook];
        
        [aBook release];
        aBook = nil;
    }
    else
        [aBook setValue:currentElementValue forKey:elementName];
    
    [currentElementValue release];
    currentElementValue = nil;
}
@end
